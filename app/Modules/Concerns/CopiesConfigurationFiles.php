<?php

namespace App\Modules\Concerns;

trait CopiesConfigurationFiles
{
    public function copyConfigurationFile(string $source, string $destination, array $replaceFrom, array $replaceTo)
    {
        $config = Storage::get('transmission-settings.json');

        $config = $this->replaceConfigString($config, $replaceFrom, $replaceTo);

        $this->createDirectoryStructureForFilePath($destination);

        $bytesWritten = file_put_contents($destination, $config);
    }

    public function replaceConfigString($configString, $replaceFrom, $replaceTo)
    {
        $configString = str_replace($replaceFrom, $replaceTo, $configString);

        return $configString;
    }

    public function createDirectoryStructureForFilePath($filePath)
    {
        $destFolder = substr($filePath, 0, strrpos($filePath, '/'));
        if (!file_exists($destFolder)) {
            // Recursively create destination folder structure
            $bool = mkdir($destFolder, 0777, true);
        }
    }
}
