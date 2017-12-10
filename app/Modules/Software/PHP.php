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
    protected $service = 'php7.2-fpm';

    protected $packages = [
        'php7.2',
        'php7.2-cli',
        'php7.2-common',
        'php7.2-curl',
        'php7.2-fpm',
        'php7.2-gd',
        'php7.2-gmp',
        'php7.2-mbstring',
        'php7.2-mcrypt',
        'php7.2-mysql',
        'php7.2-opcache',
        'php7.2-pgsql',
        'php7.2-readline',
        'php7.2-sqlite3',
        'php7.2-xml',
        'php7.2-zip',
    ];

    public function getVersion(): string
    {
        return `php -v`;
    }
}
