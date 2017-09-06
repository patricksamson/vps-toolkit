<?php

namespace App\Modules\Software;

class PHP extends AbstractAptGetSoftware
{
    protected $repository = 'ondrej/php';

    protected $executable = 'php';
    protected $service = 'php7.1-fpm';

    protected $packages = [
        'php7.1',
        'php7.1-cli',
        'php7.1-common',
        'php7.1-curl',
        'php7.1-fpm',
        'php7.1-gd',
        'php7.1-gmp',
        'php7.1-mbstring',
        'php7.1-mcrypt',
        'php7.1-mysql',
        'php7.1-opcache',
        'php7.1-pgsql',
        'php7.1-readline',
        'php7.1-sqlite3',
        'php7.1-xml',
        'php7.1-zip',
    ];

    public function getVersion()
    {
        return `php -v`;
    }
}
