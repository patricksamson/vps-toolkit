<?php

namespace App\Modules\Software;

class Transmission extends AbstractAptGetSoftware
{
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
