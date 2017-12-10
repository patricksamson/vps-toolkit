<?php

namespace App\Modules\Concerns;

trait CopiesConfigurationFiles
{
    protected $configurationFiles = [
        // 'source_path' => 'destination/path',
    ];

    public function copyConfigurationFiles()
    {
        foreach ($this->configurationFiles as $source => $destination) {
            // TODO
        }
    }
}
