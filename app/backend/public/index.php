<?php
require_once dirname(__DIR__).'/vendor/autoload.php';

use Webfux\POC\Kernel;
$kernel = new Kernel();
echo $kernel->HelloWorld();