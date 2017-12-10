<?php

namespace App\Modules\Concerns;

trait SetsPermissions
{
    //protected $permissions = [];

    public function setPermissionsRecursive()
    {
        // TODO

        /*
         * Properties
         * - recursive?
         * - set owner (user and group)
         * - set access level
         * - file or path
         */
    }

    public function setPermission(string $filename, int $mode = 0755)
    {
        $bool = chmod($filename, $mode);
    }

    public function setOwner(string $filename, string $user)
    {
        $bool = chown($filename, $user);
    }

    public function setGroup(string $filename, string $group)
    {
        $bool = chgrp($filename, $group);
    }
}
