<?php

namespace App\Modules\Concerns;

use App\Modules\Contracts\Installable;

trait HasDependencies
{
    /**
     * A list of this software's dependencies.
     * Must be Installable classes.
     *
     * @var array
     */
    protected $dependencies = [];

    public function installDependencies()
    {
        $list = [];

        foreach ($this->dependencies as $dep) {
            array_push($list, [$dep]);
        }

        $this->shell->table(['Dependencies'], $list);

        foreach ($this->dependencies as $dep) {
            if (is_subclass_of($dep, Installable::class)) {
                $instance = new $dep($this->shell);
                if (!$instance->isInstalled()) {
                    $instance->install();
                }
            }
        }
    }
}
