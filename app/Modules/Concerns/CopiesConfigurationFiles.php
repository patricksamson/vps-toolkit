<?php

namespace App\Modules\Concerns;

trait CopiesConfigurationFiles
{
    public function copyConfigurationFile($source, $destination)
    {
        // Recursively create destination folder
        $bool = mkdir($destination, 0777, true);

        $bool = copy($source, $destination);
    }
}
