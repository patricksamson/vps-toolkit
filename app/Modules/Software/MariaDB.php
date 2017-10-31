<?php

namespace App\Modules\Software;

use App\Modules\Concerns\HasService;

class MariaDB extends AbstractAptGetSoftware
{
    use HasService;

    protected $name = 'MariaDB';
    protected $description = '';

    protected $packages = [
        'mariadb-server',
    ];

    protected $executable = 'mysql';
    protected $service = 'mysql';

    protected function addAptRepository()
    {
        $lsb_release = `lsb_release -sc`; // The Ubuntu release. Precise, Trusty, Xenial, etc...
        `sudo apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xF1656F24C74CD1D8`;
        `sudo add-apt-repository 'deb [arch=amd64,i386] http://nyc2.mirrors.digitalocean.com/mariadb/repo/10.2/ubuntu {$lsb_release} main'`;
    }

    public function getVersion(): string
    {
        return `mysql -V`;
    }
}
