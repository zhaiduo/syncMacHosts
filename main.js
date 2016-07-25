// casperjs main.js
var casper = require('casper').create();

var domain;
if (casper.cli.args && casper.cli.args.length && casper.cli.args[0].match(/^[0-9a-z\.\-]+$/i)) {
    domain = casper.cli.args[0];
} else {
    console.log('［提示］请输入域名：');
    casper.done();
}
var domainReg = domain.replace(/([\.\-])/ig, "\\$1");
casper.start('http://network-tools.com/default.asp?prog=ping&host=' + domain);
var html;
var re = new RegExp("Ping ([0-9\\.]+)<br> \\[" + domainReg + "\\]", "i");
var ip;
var childProcess;

casper.waitForFileExec = function(process, ip, domain, callback, onTimeout, timeout) {
    this.then(function() {
        var cp = require('child_process'),
            finished = false,
            self = this;
        timeout = timeout === null || this.options.stepTimeout;
        cp.execFile(process, [ip, domain], {}, function(error, stdout, stderr) {
            finished = true;
            callback.call(self, error, stdout, stderr);
        });
        this.waitFor(function check() {
            return finished;
        }, null, onTimeout, timeout);
    });
    return this; // for builder/promise pattern
};

casper.then(function() {
    html = this.getHTML();
    //for test
    //html = '<br><br>Ping 151.101.129.69<br> [cdn.sstatic.net]<br>';
    if (html.match(re)) {
        ip = RegExp.$1;
        casper.waitForFileExec('./syncHosts.sh', ip, domain, function(error, stdout, stderr) {
            console.log('waitForFileExec', error, stdout, stderr);
            console.log('完成同步');
        });
    }
});

casper.run(function() {
    casper.done();
});