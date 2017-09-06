<?php

namespace App\Modules\Software;

class Nodejs extends AbstractAptGetSoftware
{
    protected $packages = [
        'nodejs',
    ];

    protected $executable = 'node';

    protected function addAptRepository()
    {
        `curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -`;
    }

    public function getVersion()
    {
        return `node -v`;
    }
}
