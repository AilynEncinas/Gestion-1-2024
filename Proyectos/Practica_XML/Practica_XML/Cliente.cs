using System;
using System.IO;
using System.Linq;
using System.Xml.Linq;
using System.Xml.Serialization;
namespace Practica_XML
{
    public class Cliente
    {
        public int CI { get; set; }
        public string Nombre { get; set; }
        public string Apellido { get; set; }
        public string Username { get; set; }
        public string Contraseña { get; set; }
        public string Direccion { get; set; }
        public DateTime Fecha { get; set; }
        public string TipoCli { get; set; }

        public static Cliente[] getCliente(int num)
        {
            Cliente[] vecCli = new Cliente[num];
            for (int i = 0; i < num; i++)
            {
                Console.WriteLine($"Ingrese los datos para el cliente {i + 1}:");

                Console.Write("CI: ");
                int ci = int.Parse(Console.ReadLine());

                Console.Write("Nombre: ");
                string nom = Console.ReadLine();

                Console.Write("Apellido: ");
                string ape = Console.ReadLine();

                Console.Write("Username: ");
                string user = Console.ReadLine();

                Console.Write("Contraseña: ");
                string contra = Console.ReadLine();

                Console.Write("Direccion: ");
                string direc = Console.ReadLine();

                Console.Write("Fecha (yyyy-MM-dd): ");
                DateTime fecha = DateTime.Parse(Console.ReadLine());

                Console.Write("TipoCli: ");
                string tipo = Console.ReadLine();

                vecCli[i] = new Cliente
                {
                    CI = ci,
                    Nombre = nom,
                    Apellido = ape,
                    Username = user,
                    Contraseña = contra,
                    Direccion = direc,
                    Fecha = fecha,
                    TipoCli = tipo
                };
            }
            return vecCli;
        }

        public static void GuardarClientesEnXML(Cliente[] clientes, string rutaArchivo)
        {
            XmlSerializer serializer = new XmlSerializer(typeof(Cliente[]));
            using (StreamWriter writer = new StreamWriter(rutaArchivo))
            {
                serializer.Serialize(writer, clientes);
            }
        }

        public static void GuardarClientesEnXML(XDocument xmlDoc, Cliente[] clientes, string rutaArchivo)
        {
            XElement root = xmlDoc.Root;
            foreach (var cliente in clientes)
            {
                XElement clienteElement = new XElement("Cliente",
                    new XElement("CI", cliente.CI),
                    new XElement("Nombre", cliente.Nombre),
                    new XElement("Apellido", cliente.Apellido),
                    new XElement("Username", cliente.Username),
                    new XElement("Contraseña", cliente.Contraseña),
                    new XElement("Direccion", cliente.Direccion),
                    new XElement("Fecha", cliente.Fecha.ToString("yyyy-MM-dd")),
                    new XElement("TipoCli", cliente.TipoCli)
                );
                root.Add(clienteElement);
            }
            xmlDoc.Save(rutaArchivo);
        }
    }
}
