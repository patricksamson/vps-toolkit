<?php

namespace App\Modules\Software;

class Automysqlbackup extends AbstractAptGetSoftware
{
    protected $packages = [
        'automysqlbackup',
    ];

    protected $executable = 'automysqlbackup';

    public function getVersion()
    {
        return `unknown`;
    }
}
