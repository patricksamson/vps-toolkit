<?php

namespace App\Modules\Software;

class Nodejs extends AbstractAptGetSoftware
{
    protected $name = 'Node.js';
    protected $description = '';

    protected $packages = [
        'nodejs',
    ];

    protected $executable = 'node';

    protected function addAptRepository()
    {
        `curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -`;
    }

    public function getVersion(): string
    {
        return `node -v`;
    }
}
