<?php

namespace App\Modules\Software;

use App\Modules\Utils\ShellOutput;

abstract class AbstractBaseSoftware
{
    protected $ouptut;

    protected $name;
    protected $description;

    public function __construct(ShellOutput $ouptut)
    {
        $this->output = $ouptut;
    }

    public function getKey()
    {
        return strtolower($this->name);
    }

    public function getName(): string
    {
        return $this->name;
    }

    public function getDescription(): string
    {
        return $this->description;
    }
}
