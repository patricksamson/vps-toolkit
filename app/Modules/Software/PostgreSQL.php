<?php

namespace App\Modules\Software;

use App\Modules\Concerns\HasService;

class PostgreSQL extends AbstractAptGetSoftware
{
    use HasService;

    protected $name = 'PostgreSQL';
    protected $description = '';

    protected $packages = [
        'postgresql',
        'postgresql-contrib',
    ];

    protected $executable = 'psql';
    protected $service = 'postgresql';

    protected function addAptRepository()
    {
        $lsb_release = `lsb_release -sc`; // The Ubuntu release. Precise, Trusty, Xenial, etc...
        `sudo add-apt-repository 'deb http://apt.postgresql.org/pub/repos/apt/ {$lsb_release}-pgdg main'`;
        `wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -`;
    }

    public function getVersion(): string
    {
        return ''.`psql --version`;
    }
}
