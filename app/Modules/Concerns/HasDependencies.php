<?php

namespace App\Modules\Concerns;

use App\Modules\Contracts\Installable;

trait HasDependencies
{
    protected $dependencies = [];

    public function installDependencies()
    {
        foreach ($this->dependencies as $dep) {
            if ($dep instanceof Installable) {
                if (!$dep->isInstalled()) {
                    $dep->install();
                }
            }
        }
    }
}
