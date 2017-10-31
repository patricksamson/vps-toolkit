<?php

namespace App\Modules\Software;

use App\Modules\Concerns\HasService;

class Transmission extends AbstractAptGetSoftware
{
    use HasService;

    protected $name = 'Transmission';
    protected $description = '';

    protected $repository = 'transmissionbt/ppa';

    protected $packages = [
        'transmission-cli',
        'transmission-common',
        'transmission-daemon',
    ];

    protected $executable = 'transmission-daemon';
    protected $service = 'transmission-daemon';

    protected $dependencies = [Nginx::class];

    public function getVersion(): string
    {
        return ''.`transmission-daemon -V`;
    }
}
