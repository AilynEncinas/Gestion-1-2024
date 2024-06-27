using System;
using System.Collections.Generic;
using System.Linq;
using System.Xml.Linq;
using System.Text;
using System.Threading.Tasks;
using System.IO;

namespace Practica_XML
{
    class Program
    {
        static void Main(string[] args)
        {
            string defaultPath = "";
            string filePath = "";
            XDocument xmlDoc = null;

            while (true)
            {
                Console.WriteLine("Menú XML:");
                Console.WriteLine("1. Cargar archivo XML");
                Console.WriteLine("2. Mostrar el contenido del archivo");
                Console.WriteLine("3. Registrar cliente archivo XML");
                Console.WriteLine("4. Ejecutar consultas LINQ");
                Console.WriteLine("5. Salir");
                Console.Write("Elige una opción: ");
                string option = Console.ReadLine();

                switch (option)
                {
                    case "1":
                        defaultPath = @"C:\Users\HP\source\repos\Practica_XML\Practica_XML\XML\";

                        Console.Write("Ingresa el nombre del archivo XML (sin extensión): ");
                        string fileName = Console.ReadLine();
                        filePath = Path.Combine(defaultPath, $"{fileName}.xml");

                        if (File.Exists(filePath))
                        {
                            xmlDoc = XDocument.Load(filePath);
                            Console.WriteLine("Archivo cargado exitosamente.");
                        }
                        else
                        {
                            Console.WriteLine("Archivo no encontrado.");
                        }
                        Console.ReadLine();
                        Console.Clear();
                        break;
                    case "2":
                        if (xmlDoc == null)
                        {
                            Console.WriteLine("No hay archivo XML cargado.");
                        }
                        else
                        {
                            Console.WriteLine("El contenido del archivo es:");
                            Console.WriteLine(xmlDoc);
                        }
                        Console.ReadLine();
                        Console.Clear();
                        break;

                    case "3":
                        Console.Write("Ingrese el número de clientes a registrar: ");
                        int num = int.Parse(Console.ReadLine());

                        Cliente[] clientes = Cliente.getCliente(num);

                        foreach (var cliente in clientes)
                        {
                            Console.WriteLine($"CI: {cliente.CI}, Nombre: {cliente.Nombre}, Apellido: {cliente.Apellido}, Username: {cliente.Username}, Direccion: {cliente.Direccion}, Fecha: {cliente.Fecha}, Tipo: {cliente.TipoCli}");
                        }

                        Console.WriteLine("Elige una opción para guardar los clientes:");
                        Console.WriteLine("1. Guardar en el archivo XML cargado");
                        Console.WriteLine("2. Crear un nuevo archivo XML");
                        Console.Write("Opción: ");
                        string saveOption = Console.ReadLine();

                        if (saveOption == "1")
                        {
                            if (xmlDoc == null)
                            {
                                Console.WriteLine("No hay archivo XML cargado.");
                            }
                            else
                            {
                                Cliente.GuardarClientesEnXML(xmlDoc, clientes, filePath);
                                Console.WriteLine($"Los datos han sido guardados en el archivo XML: {filePath}");
                            }
                        }
                        else if (saveOption == "2")
                        {
                            Console.Write("Ingrese la ruta donde desea guardar el archivo XML: ");
                            string ruta = Console.ReadLine();

                            Console.Write("Ingrese el nombre del archivo XML (sin extensión): ");
                            string nombreArchivo = Console.ReadLine();
                            string rutaArchivo = Path.Combine(ruta, $"{nombreArchivo}.xml");

                            Cliente.GuardarClientesEnXML(clientes, rutaArchivo);

                            Console.WriteLine($"Los datos han sido guardados en el nuevo archivo XML: {rutaArchivo}");
                        }
                        else
                        {
                            Console.WriteLine("Opción inválida.");
                        }
                        Console.ReadLine();
                        Console.Clear();
                        break;

                    case "4":
                        if (xmlDoc == null)
                        {
                            Console.WriteLine("No hay archivo XML cargado.");
                        }
                        else
                        {
                            Console.WriteLine("Elige una consulta:");
                            Console.WriteLine("1. Obtener todos los CIs de los clientes");
                            Console.WriteLine("2. Obtener todos los nombres de los clientes");
                            Console.WriteLine("3. Obtener clientes con TipoCli 'VIP'");
                            Console.WriteLine("4. Obtener clientes cuya fecha de registro sea después de una fecha específica");
                            Console.Write("Opción: ");
                            string consultaOption = Console.ReadLine();

                            switch (consultaOption)
                            {
                                case "1":
                                    var query1 = from cliente in xmlDoc.Descendants("Cliente")
                                                 select cliente.Element("CI").Value;
                                    Console.WriteLine("Consulta 1: CIs de los clientes:");
                                    foreach (var ci in query1)
                                    {
                                        Console.WriteLine(ci);
                                    }
                                    break;

                                case "2":
                                    var query2 = from cliente in xmlDoc.Descendants("Cliente")
                                                 select cliente.Element("Nombre").Value;
                                    Console.WriteLine("Consulta 2: Nombres de los clientes:");
                                    foreach (var nombre in query2)
                                    {
                                        Console.WriteLine(nombre);
                                    }
                                    break;

                                case "3":
                                    var query3 = from cliente in xmlDoc.Descendants("Cliente")
                                                 where cliente.Element("TipoCli").Value == "VIP"
                                                 select cliente;
                                    Console.WriteLine("Consulta 3: Clientes con TipoCli 'VIP':");
                                    foreach (var cliente in query3)
                                    {
                                        Console.WriteLine(cliente);
                                    }
                                    break;

                                case "4":
                                    Console.Write("Ingrese la fecha (yyyy-MM-dd): ");
                                    DateTime fechaConsulta = DateTime.Parse(Console.ReadLine());

                                    var query4 = from cliente in xmlDoc.Descendants("Cliente")
                                                 where DateTime.Parse(cliente.Element("Fecha").Value) > fechaConsulta
                                                 select cliente;
                                    Console.WriteLine("Consulta 4: Clientes registrados después de la fecha especificada:");
                                    foreach (var cliente in query4)
                                    {
                                        Console.WriteLine(cliente);
                                    }
                                    break;

                                default:
                                    Console.WriteLine("Opción de consulta inválida.");
                                    break;
                            }
                        }
                        Console.ReadLine();
                        Console.Clear();
                        break;

                    case "5":
                        return;

                    default:
                        Console.WriteLine("Opción inválida. Por favor, intenta de nuevo.");
                        break;
                }
            }
        }
    }
}
