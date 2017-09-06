<?php

namespace App\Modules\Software;

use App\Modules\Concerns\HasService;

class Nginx extends AbstractAptGetSoftware
{
    use HasService;

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
