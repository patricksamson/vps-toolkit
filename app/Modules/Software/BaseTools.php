<?php

namespace App\Modules\Software;

class BaseTools extends AbstractAptGetSoftware
{
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

    public function getVersion()
    {
    }
}
