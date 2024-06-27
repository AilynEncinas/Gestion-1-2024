using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
//Pongo esto para que un error desaparezca Referencias/agregaer/configuration/aceptar
using System.Configuration;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace Progra3
{
    /// <summary>
    /// Lógica de interacción para MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();
        }

        private void Clientes_Click(object sender, RoutedEventArgs e)
        {
            ClientesWindow clientesWindow = new ClientesWindow();
            clientesWindow.ShowDialog(); // Mostrar la ventana como diálogo
        }

        private void Ordenes_Click(object sender, RoutedEventArgs e)
        {
            OrdenesWindow ordenesWindow = new OrdenesWindow();
            ordenesWindow.ShowDialog(); // Mostrar la ventana como diálogo
        }

        private void DetalleOrdenes_Click(object sender, RoutedEventArgs e)
        {
            DetalleOrdWindow detalleOrdWindow = new DetalleOrdWindow();
            detalleOrdWindow.ShowDialog(); // Mostrar la ventana como diálogo
        }

        private void Tarjetas_Click(object sender, RoutedEventArgs e)
        {
            TarjetasWindow tarjetasWindow = new TarjetasWindow();
            tarjetasWindow.ShowDialog(); // Mostrar la ventana como diálogo
        }
    }
}
