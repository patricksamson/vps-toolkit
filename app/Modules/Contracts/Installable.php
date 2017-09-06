<?php

namespace App\Modules\Contracts;

interface Installable
{
    public function install();

    public function remove();

    public function isInstalled(): bool;

    public function getVersion(): string;
}
