<?php

   // Include the Smarty Templating Engine
   define('SMARTY_DIR', __DIR__ . '/Smarty-3.1.14/libs/');
   require_once(SMARTY_DIR . 'Smarty.class.php');
   $smarty = new Smarty();

   $smarty->setTemplateDir(__DIR__ . '/templates/templates/');
   $smarty->setCompileDir(__DIR__ . '/templates/templates_c/');
   $smarty->setConfigDir(__DIR__ . '/templates/configs/');
   $smarty->setCacheDir(__DIR__ . '/templates/cache/');

   // Notice how you can set variables here in the PHP that will get carried into the template files
   $smarty->assign('title', "EECS485");


   // Setup the Routing Framework
   require_once __DIR__ . '/vendor/autoload.php';
   $klein = new \Klein\Klein();


   /* Define routes here */

   $klein->respond('GET', '/', function ($request, $response, $service) use ($smarty) {
     $smarty->display('index.tpl');
   });

   $klein->respond('GET', '/pic[:id]?', function ($request, $response, $service) use ($smarty) {

     // Notice how you can set variables here in the PHP that will get carried into the template files
     $smarty->assign('picid', $request->id);

     $smarty->display('pic.tpl');
   });

   $klein->respond('GET', '/album', function ($request, $response, $service) use ($smarty) {
     $smarty->display('album.tpl');
   });

   $klein->respond('GET', '/albums', function ($request, $response, $service) use ($smarty) {
     $smarty->display('albums.tpl');
   });


   $klein->dispatch();

?>
