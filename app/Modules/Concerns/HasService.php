<?php

namespace App\Modules\Concerns;

trait HasService
{
    protected $service;

    public function hasService()
    {
        return $this->service != null;
    }

    public function startService()
    {
        if ($this->hasService()) {
            `sudo service {$this->service} start`;
        }
    }

    public function reloadService()
    {
        if ($this->hasService()) {
            `sudo service {$this->service} reload`;
        }
    }

    public function restartService()
    {
        if ($this->hasService()) {
            `sudo service {$this->service} restart`;
        }
    }

    public function stopService()
    {
        if ($this->hasService()) {
            `sudo service {$this->service} stop`;
        }
    }
}
