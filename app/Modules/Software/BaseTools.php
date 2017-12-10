<?php

namespace App\Modules\Software;

class BaseTools extends AbstractAptGetSoftware
{
    protected $name = 'Base Tools';
    protected $description = 'Installs many basics tools such as Git, Nano, curl, ...';

    protected $repository = 'git-core/ppa';

    protected $packages = [
        'curl',
        'fail2ban',
        'git',
        'htop',
        'iftop',
        'iotop',
        'nano',
        'openssl',
        'python-software-properties',
        'software-properties-common',
        'sudo',
        'supervisor',
        'unzip',
        'wget',
    ];

    public function getVersion(): string
    {
        // TODO : Iterate over multiple executables
        return 'unknown';
    }

    public function isInstalled(): bool
    {
        // TODO : Iterate over multiple executables
        return !empty(`which supervisor`);
    }
}
