<?php

namespace App\Modules\Concerns;

trait ExecutesShellCommands
{
    private function execute()
    {
        $this->printCommand($command);

        system($command);
    }

    public function printCommand($string, $verbosity = null)
    {
        $this->output->line($string, 'question', $verbosity);
    }
}