<?php

namespace App\Modules\Software;

use App\Modules\Concerns\HasDependencies;
use App\Modules\Concerns\HasService;

class InvoiceNinja extends AbstractGitCloneableSoftware
{
    use HasService, HasDependencies;

    protected $name = 'Invoice Ninja';
    protected $description = '';

    protected $dependencies = [
        'PHP',
        'Composer',
        'MariaDB',
        'Nginx',
    ];

    protected $repository = 'https://github.com/hillelcoren/invoice-ninja.git';
    protected $installPath = '/var/www/invoice-ninja';
}
