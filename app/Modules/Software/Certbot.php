<?php

namespace App\Modules\Software;

class Certbot extends AbstractAptGetSoftware
{
    protected $name = 'Certbot';
    protected $description = '';

    protected $repository = 'certbot/certbot';

    protected $executable = 'certbot';

    protected $packages = [
        'python-certbot-nginx ',
    ];

    public function getVersion(): string
    {
        return `certbot -v`;
    }
}
