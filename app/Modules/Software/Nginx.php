<?php

namespace App\Modules\Software;

class Nginx extends AbstractAptGetSoftware
{
    protected $repository = 'nginx/development';

    protected $packages = [
        'nginx',
    ];

    protected $executable = 'nginx';
    protected $service = 'nginx';

    public function getVersion()
    {
        return `nginx -v`;
    }
}
