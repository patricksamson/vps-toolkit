<?php

namespace App\Modules\Software;

use App\Modules\Concerns\HasService;

class Transmission extends AbstractAptGetSoftware
{
    use HasService;

    protected $repository = 'transmissionbt/ppa';

    protected $packages = [
        'transmission-cli',
        'transmission-common',
        'transmission-daemon',
    ];

    protected $executable = 'transmission-daemon';
    protected $service = 'transmission-daemon';

    public function getVersion()
    {
        return `transmission-daemon -V`;
    }
}
