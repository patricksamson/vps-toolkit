<?php

namespace App\Modules\Software;

use App\Modules\Concerns\HasService;

class PHP extends AbstractAptGetSoftware
{
    use HasService;

    protected $name = 'PHP';
    protected $description = '';

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

    public function getVersion(): string
    {
        return `php -v`;
    }
}
