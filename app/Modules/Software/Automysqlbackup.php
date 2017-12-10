<?php

namespace App\Modules\Software;

class Automysqlbackup extends AbstractAptGetSoftware
{
    protected $name = 'Automysqlbackup';
    protected $description = '';

    protected $packages = [
        'automysqlbackup',
    ];

    protected $executable = 'automysqlbackup';

    public function getVersion(): string
    {
        return 'unknown';
    }
}
