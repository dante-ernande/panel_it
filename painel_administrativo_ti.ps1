Add-Type -AssemblyName PresentationFramework

[xml]$xaml = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="Painel Administrativo de TI" Height="450" Width="750" Background="#1C1C1C">
    <Grid Margin="20">
        <Grid.ColumnDefinitions>
            <ColumnDefinition Width="150"/> <ColumnDefinition Width="*"/>
            <ColumnDefinition Width="*"/>
            <ColumnDefinition Width="*"/>
            <ColumnDefinition Width="*"/>
        </Grid.ColumnDefinitions>

        <Grid.RowDefinitions>
            <RowDefinition Height="*"/>
            <RowDefinition Height="*"/>
            <RowDefinition Height="*"/>
        </Grid.RowDefinitions>

        <Border Grid.Row="0" Grid.Column="0" BorderBrush="#E8C861" BorderThickness="2" Margin="5" Background="#1C1C1C">
            <TextBlock Text="REDE" Foreground="#E8C861" HorizontalAlignment="Center" VerticalAlignment="Center" FontWeight="Bold" FontSize="14"/>
        </Border>
        <Border Grid.Row="1" Grid.Column="0" BorderBrush="#E8C861" BorderThickness="2" Margin="5" Background="#1C1C1C">
            <TextBlock Text="GERENCIAMENTO" Foreground="#E8C861" HorizontalAlignment="Center" VerticalAlignment="Center" FontWeight="Bold" FontSize="14"/>
        </Border>
        <Border Grid.Row="2" Grid.Column="0" BorderBrush="#E8C861" BorderThickness="2" Margin="5" Background="#1C1C1C">
            <TextBlock Text="SISTEMA" Foreground="#E8C861" HorizontalAlignment="Center" VerticalAlignment="Center" FontWeight="Bold" FontSize="14"/>
        </Border>

        <Button x:Name="NetNcpa" Grid.Row="0" Grid.Column="1" Margin="10" Background="White" BorderThickness="0" Cursor="Hand">
            <TextBlock Text="Adaptadores&#x0a;de Rede" TextAlignment="Center" FontSize="16" FontWeight="Bold" FontStyle="Italic"/>
        </Button>
        <Button x:Name="NetMstsc" Grid.Row="0" Grid.Column="2" Margin="10" Background="#E8C861" BorderThickness="0" Cursor="Hand">
            <TextBlock Text="Desktop&#x0a;Remoto" TextAlignment="Center" FontSize="16" FontWeight="Bold" FontStyle="Italic"/>
        </Button>
        <Button x:Name="NetWf" Grid.Row="0" Grid.Column="3" Margin="10" Background="White" BorderThickness="0" Cursor="Hand">
            <TextBlock Text="Firewall&#x0a;Avançado" TextAlignment="Center" FontSize="16" FontWeight="Bold" FontStyle="Italic"/>
        </Button>
        <Button x:Name="NetInetcpl" Grid.Row="0" Grid.Column="4" Margin="10" Background="#E8C861" BorderThickness="0" Cursor="Hand">
            <TextBlock Text="Opções de&#x0a;Internet" TextAlignment="Center" FontSize="16" FontWeight="Bold" FontStyle="Italic"/>
        </Button>

        <Button x:Name="GmtServices" Grid.Row="1" Grid.Column="1" Margin="10" Background="#E8C861" BorderThickness="0" Cursor="Hand">
            <TextBlock Text="Serviços&#x0a;do Windows" TextAlignment="Center" FontSize="16" FontWeight="Bold" FontStyle="Italic"/>
        </Button>
        <Button x:Name="GmtDiskmgmt" Grid.Row="1" Grid.Column="2" Margin="10" Background="White" BorderThickness="0" Cursor="Hand">
            <TextBlock Text="Gerenciador&#x0a;de Discos" TextAlignment="Center" FontSize="16" FontWeight="Bold" FontStyle="Italic"/>
        </Button>
        <Button x:Name="GmtCompmgmt" Grid.Row="1" Grid.Column="3" Margin="10" Background="#E8C861" BorderThickness="0" Cursor="Hand">
            <TextBlock Text="Gerenciador&#x0a;do PC" TextAlignment="Center" FontSize="16" FontWeight="Bold" FontStyle="Italic"/>
        </Button>
        <Button x:Name="GmtEventvwr" Grid.Row="1" Grid.Column="4" Margin="10" Background="White" BorderThickness="0" Cursor="Hand">
            <TextBlock Text="Visualizador&#x0a;de Eventos" TextAlignment="Center" FontSize="16" FontWeight="Bold" FontStyle="Italic"/>
        </Button>

        <Button x:Name="SysRegedit" Grid.Row="2" Grid.Column="1" Margin="10" Background="White" BorderThickness="0" Cursor="Hand">
            <TextBlock Text="Editor do&#x0a;Registro" TextAlignment="Center" FontSize="16" FontWeight="Bold" FontStyle="Italic"/>
        </Button>
        <Button x:Name="SysAppwiz" Grid.Row="2" Grid.Column="2" Margin="10" Background="#E8C861" BorderThickness="0" Cursor="Hand">
            <TextBlock Text="Programas e&#x0a;Recursos" TextAlignment="Center" FontSize="16" FontWeight="Bold" FontStyle="Italic"/>
        </Button>
        <Button x:Name="SysResmon" Grid.Row="2" Grid.Column="3" Margin="10" Background="White" BorderThickness="0" Cursor="Hand">
            <TextBlock Text="Monitor de&#x0a;Recursos" TextAlignment="Center" FontSize="16" FontWeight="Bold" FontStyle="Italic"/>
        </Button>
        <Button x:Name="SysMsconfig" Grid.Row="2" Grid.Column="4" Margin="10" Background="#E8C861" BorderThickness="0" Cursor="Hand">
            <TextBlock Text="Configuração&#x0a;do Sistema" TextAlignment="Center" FontSize="16" FontWeight="Bold" FontStyle="Italic"/>
        </Button>

    </Grid>
</Window>
"@

$reader = (New-Object System.Xml.XmlNodeReader $xaml)
$window = [System.Windows.Markup.XamlReader]::Load($reader)

# ==========================================
# 2. FUNÇÃO CENTRAL PARA ABRIR PROGRAMAS
# ==========================================
function Abrir-Programa ($NomeDoExecutavel) {
    Write-Host "Iniciando: $NomeDoExecutavel" -ForegroundColor Cyan
    try {
        Start-Process -FilePath $NomeDoExecutavel -ErrorAction Stop
    }
    catch {
        Write-Host "Erro ao tentar abrir: $NomeDoExecutavel" -ForegroundColor Red
    }
} 

# ==========================================
# 3. ATRIBUIÇÃO DOS EVENTOS (Muito mais limpo)
# ==========================================

# Rede
$window.FindName("NetNcpa").Add_Click({ Abrir-Programa "ncpa.cpl" })
$window.FindName("NetMstsc").Add_Click({ Abrir-Programa "mstsc.exe" })
$window.FindName("NetWf").Add_Click({ Abrir-Programa "wf.msc" })
$window.FindName("NetInetcpl").Add_Click({ Abrir-Programa "inetcpl.cpl" })

# Gerenciamento
$window.FindName("GmtServices").Add_Click({ Abrir-Programa "services.msc" })
$window.FindName("GmtDiskmgmt").Add_Click({ Abrir-Programa "diskmgmt.msc" })
$window.FindName("GmtCompmgmt").Add_Click({ Abrir-Programa "compmgmt.msc" })
$window.FindName("GmtEventvwr").Add_Click({ Abrir-Programa "eventvwr.msc" })

# Sistema
$window.FindName("SysRegedit").Add_Click({ Abrir-Programa "regedit.exe" })
$window.FindName("SysAppwiz").Add_Click({ Abrir-Programa "appwiz.cpl" })
$window.FindName("SysResmon").Add_Click({ Abrir-Programa "resmon.exe" })
$window.FindName("SysMsconfig").Add_Click({ Abrir-Programa "msconfig.exe" })

# Exibe a janela
$window.ShowDialog() | Out-Null