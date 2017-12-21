<?php

namespace App\Modules\Concerns;

trait ExecutesShellCommands
{
    private function execute($command)
    {
        $this->printCommand($command);

        system($command);
        //shell_exec($command);
    }

    public function printCommand($string, $verbosity = null)
    {
        $this->output->line($string, 'question', $verbosity);
    }
}
