using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;

namespace Progra3
{
    /// <summary>
    /// Lógica de interacción para ClientesWindow.xaml
    /// </summary>
    public partial class ClientesWindow : Window
    {
        private DataClasses1DataContext dataContext;

        public ClientesWindow()
        {
            InitializeComponent();
            dataContext = new DataClasses1DataContext(); // Inicializar tu DataContext aquí

            CargarClientes(); // Llamar al método para cargar clientes al DataGrid
        }

        private void CargarClientes()
        {
            try
            {
                // Obtener datos de la tabla Clientes usando LINQ to SQL
                var clientes = dataContext.Cliente.ToList(); // Aquí Clientes es el nombre de la tabla

                dgClientes.ItemsSource = clientes; // Asignar la lista de clientes al DataGrid
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Error al cargar clientes: {ex.Message}");
            }
        }
    }
}
