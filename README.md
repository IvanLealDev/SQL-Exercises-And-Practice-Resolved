<h1 align="center">SQL-Exercises-And-Practice-Resolved</h1>

## Description

<h2>Consultas</h2>
<p>This file queries a database called EMPRESA, focusing on sales and products.</p>
<ul>
    <li>Drop the ITEM_VENTAS, VENTAS, and PRODUCTO tables before running queries.</li>
    <li>Calculate the total amount of each sale by adding the quantity sold of each product multiplied by its unit price.</li>
    <li>Filter sales with an amount greater than 5000.</li>
    <li>Create a view (CantidadVendidaPorProducto) to get the total quantity sold for each product.</li>
    <li>Get the best and least sold product, using TOP 1 and ORDER BY.</li>
</ul>
<br>
<h2>CreacionTabla</h2>
<p>Defines the structure of the EMPRESA database, creating three main tables:</p>
<ul>
    <li>VENTAS: Contains sales information (number, type and date).</li>
    <li>ITEM_SALES: Records the products sold in each sale, with references to VENTAS and PRODUCTO.</li>
    <li>PRODUCTO: Stores product information, including price and description.</li>
</ul>
<br>
<h2>Práctica SQL - Lenguaje estructurado de Consulta</h2>
<p>Performs operations in the SQL_SERVER database, working with the Alumno table.</p>
<ul>
    <li>Enter student data with their file, last name, first name, age, and residence.</li>
    <li>Run queries to filter students by residence, age, and last name.</li>
    <li>Some queries contain syntax errors (incorrect use of commas in WHERE).</li>
</ul>
<br>
<h2>Relleno Tabla</h2>
<p>Populate the EMPRESA database with test data.</p>
<ul>
    <li>Deletes existing records in ITEM_VENTAS, VENTAS and PRODUCTO.</li>
    <li>Insert sales with different dates and types.</li>
    <li>Add products with name, price and description.</li>
    <li>Relates sales and products in ITEM_VENTAS.</li>
</ul>
<br>
<h2>Select within Select - Base de Datos</h2>
<p>Exercises with advanced queries using subqueries (SELECT within SELECT) on a database of countries (world).</p>
<ul>
    <li>Find countries with larger populations than Russia.</li>
    <li>Filters European countries with a GDP per capita greater than that of the United Kingdom.</li>
    <li>Order countries on certain continents.</li>
    <li>Get countries within a population range.</li>
    <li>Calculate the population of European countries as a percentage of that of Germany.</li>
    <li>Find countries with a higher GDP than any country in Europe.</li>
    <li>Identify the largest country by area on each continent.</li>
    <li>List the first country alphabetically on each continent.</li>
    <li>Find continents where all countries have a population ≤ 25 million.</li>
    <li>Find countries with more than three times the population of any neighbor on their continent.</li>
</ul>
<br>
<h2>SQLQuery1</h2>
<p>Create and structure a database called tpn2, focused on a billing system.</p>
<ul>
    <li>Defines the tables: Clientes, SitIva, Articulos, Marcas, Localidades, Facturas, DetallesFacturas, Distribuidores.</li>
    <li>Establishes foreign keys to ensure referential integrity.</li>
    <li>Insert test data into customers, items, brands, locations, invoices, and distributors.</li>
    <li>Create views for frequently asked queries, such as: Invoices from clients named “Pepe” and Clients from specific municipalities.</li>
</ul>
<br>
<h2>SQLQuery2</h2>
<p>This script creates and configures a database called TpTrigger with the following functionality:</p>
<ul>
    Main tables:
    <ol>
        <li>Articulos: Store items with code, name, price, last purchase date, and brand reference.</li>
        <li>Marcas: Contains the brands of the items.</li>
        <li>Logx: Records changes to items.</li>
    </ol>
    Triggers:
    <ol>
        <li>primerTrig: Triggered after an update to Articulos, recording the price change in Logx. It's modified to include the date of the change and the user who made it.</li>
        <li>segundoTrig: Prevents the insertion of items with zero or negative prices.</li>
    </ol>
    Examples of use:
    <ol>
        <li>Insertion of brands and articles.</li>
        <li>Updating the price of an item, which generates records in Logx.</li>
        <li>Attempts to insert items with invalid prices.</li>
    </ol>
</ul>
<br>
<h2>SQLQuery3</h2>
<p>This script sets up a database called TpTrigger2 with a more complex model, including customers, billing, and inventory.</p>
<ul>
    Main tables:
    <ol>
        <li>Articulos: Similar to the other script, but with more attributes, such as stockActual and precioVenta.</li>
        <li>Facturas and DetallesFacturas: Represent sales and their details.</li>
        <li>Clients, SitIva, Localidades: Manage client information and their tax status.</li>
        <li>eventos: Records price modification attempts.</li>
        <li>Registro: Keep track of stock.</li>
    </ol>
    Triggers:
    <ol>
        <li>itento_actualizar_precio: Records attempts to change prices on eventos, storing the date, user, and the values ​​before and after the change.</li>
        <li>actualizar_articulo: Decreases the stockActual when a sale is made. If the item doesn't exist in the Registro, it's inserted with a negative value.</li>
        <li>verificar_cantidad_negativa: Prevents the sale of items with negative quantities by recording the attempt in the Registro.</li>
    </ol>
    Examples of use:
    <ol>
        <li>Insertion of brands, articles, customers and invoices.</li>
        <li>Attempts to modify prices, which generate eventos registrations.</li>
        <li>Inserting invoice details with negative amounts, which the trigger blocks.</li>
    </ol>
</ul>