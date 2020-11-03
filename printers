<# Installation des pilotes #>

pnputil.exe -i -a "C:\informatique\PREPA\COPIEURS\Kyocera Taskalfa 255xci - 405xci\Windows 7\KX7.4_v7.4.0830\64bit\OEMSETUP.inf"

pnputil.exe -i -a "C:\informatique\PREPA\COPIEURS\Konica Minolta Bizhub Cxxxx\BHC554ePCL6Winx64_5130FR\KOAYTJ__.INF"

pnputil.exe -i -a "C:\informatique\PREPA\COPIEURS\Konica Minolta Bizhub C3350\BHC3850DSETWin_3120FR\Drivers\PCL6\Win_x64\KOBJ_J__.inf"

 

<# Ajout du nom des pilotes à utiliser #>

 

Add-PrinterDriver -Name "Kyocera TASKalfa 2552ci KX"

Add-PrinterDriver -Name "Kyocera TASKalfa 2551ci KX"

Add-PrinterDriver -Name "Kyocera TASKalfa 3252ci KX"

Add-PrinterDriver -Name "Kyocera TASKalfa 4052ci KX"

Add-PrinterDriver -Name "KONICA MINOLTA C554SeriesPCL"

 

<# Copieur 22 #>

 

    <# Ateliers de la baie #>

        <# RDC #>

        Add-PrinterPort -Name "ADB_192.168.1.50" -PrinterHostAddress "192.168.1.50"

        Add-Printer -Name "Copieur Ateliers de la baie RDC" -DriverName "Kyocera TASKalfa 2552ci KX" -PortName ADB_192.168.1.50

 

        <# Étage #>

        Add-PrinterPort -Name "ADB_192.168.1.10" -PrinterHostAddress "192.168.1.10"

        Add-Printer -Name "Copieur Ateliers de la baie Étage" -DriverName "Kyocera TASKalfa 2552ci KX" -PortName ADB_192.168.1.10

 

    <# Foyer de vie Avalenn #>

        Add-PrinterPort -Name "Avalenn_192.168.11.201" -PrinterHostAddress "192.168.11.201"

       

        Add-Printer -Name "Copieur FDV Avalenn" -DriverName "Kyocera TASKalfa 2551ci KX" -PortName Avalenn_192.168.11.201

 

    <# Foyer de vie Roger LE GRAND #>

        Add-PrinterPort -Name "RLG_192.168.4.2" -PrinterHostAddress "192.168.4.2"

        Add-Printer -Name "Copieur FDV Roger LE GRAND" -DriverName "Kyocera TASKalfa 3252ci KX" -PortName RLG_192.168.4.2

 

    <# GCSMS #>

        <# RDC #>

        Add-PrinterPort -Name "GCSMS_192.168.5.2" -PrinterHostAddress "192.168.5.2"

        Add-Printer -Name "Copieur GCSMS RDC" -DriverName "Kyocera TASKalfa 4052ci KX" -PortName GCSMS_192.168.5.2

 

        <# Étage #>

        Add-PrinterPort -Name "GCSMS_192.168.5.3" -PrinterHostAddress "192.168.5.3"

        Add-PrinterDriver -Name "KONICA MINOLTA C3850 series PCL6"

        Add-Printer -Name "Copieur GCSMS Étage" -DriverName "KONICA MINOLTA C3850 series PCL6" -PortName GCSMS_192.168.5.3

 

    <# IME du Valais #>

        <# Nouveau batiment #>

        Add-PrinterPort -Name "IME22_192.168.2.12" -PrinterHostAddress "192.168.2.12"

        Add-Printer -Name "Copieur IME du Valais" -DriverName "Kyocera TASKalfa 3252ci KX" -PortName IME22_192.168.2.12

 

        <# Nouveau batiment #>

        Add-PrinterPort -Name "IME22_192.168.2.11" -PrinterHostAddress "192.168.2.11"

        Add-Printer -Name "Copieur Annexe du Valais" -DriverName "Kyocera TASKalfa 2552ci KX" -PortName IME22_192.168.2.11

 

    <# Trajectoire #>

        Add-PrinterPort -Name "TRAJECTOIRE_192.168.14.200" -PrinterHostAddress "192.168.14.200"

        Add-Printer -Name "Copieur Trajectoire" -DriverName "KONICA MINOLTA C554SeriesPCL" -PortName TRAJECTOIRE_192.168.14.200

 

<# Copieurs 29 #>

    <# Esat Claude MARTINIERE #>

        <# RDC #>

        Add-PrinterPort -Name "ESAT29_10.10.1.251" -PrinterHostAddress "10.10.1.251"

        Add-Printer -Name "Copieur ESAT Claude MARTINIERE RDC" -DriverName "Kyocera TASKalfa 3252ci KX" -PortName ESAT29_10.10.1.251

        <# Étage #>

        Add-PrinterPort -Name "ESAT29_10.10.1.77" -PrinterHostAddress "10.10.1.77"

        Add-Printer -Name "Copieur ESAT Claude MARTINIERE Étage" -DriverName "Kyocera TASKalfa 3252ci KX" -PortName ESAT29_10.10.1.77

 

    <# Foyer de vie Rumain #>

        Add-PrinterPort -Name "RUMAIN_192.168.9.203" -PrinterHostAddress "192.168.9.203"

        Add-Printer -Name "Copieur FDV Rumain" -DriverName "KONICA MINOLTA C554SeriesPCL" -PortName RUMAIN_192.168.9.203

 

    <# IME François HUON #>

        Add-PrinterPort -Name "IME29_192.168.16.213" -PrinterHostAddress "192.168.16.213"

        Add-Printer -Name "Copieur IME François HUON" -DriverName "KONICA MINOLTA C554SeriesPCL" -PortName IME29_192.168.16.213
