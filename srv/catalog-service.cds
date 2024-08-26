using {com.logali as logali} from '../db/schema';
using {com.training as training} from '../db/training';

service CatalogService_1 {
    entity Products                      as projection on logali.materials.Products;
    entity Suppliers                     as projection on logali.sales.Suppliers;
    entity UnitOfMeasures                as projection on logali.materials.UnitOfMeasures;
    entity Currency                      as projection on logali.materials.Currencies;
    entity UnitOfMeDimensionsUnitsasures as projection on logali.materials.DimensionsUnits;
    entity Category                      as projection on logali.materials.Categories;
    entity ToSalesData                   as projection on logali.sales.SalesData;
    entity Reviews                       as projection on logali.materials.ProductReview;
    entity Months                        as projection on logali.sales.Months;
    entity Order                         as projection on logali.sales.Orders;
    entity OrderItem                     as projection on logali.sales.OrderItems;
    entity SelProducts3                  as projection on logali.sales.SelProducts3;
    //////////Otras entidades:
    entity Course                        as projection on training.Course;
    entity Student                       as projection on training.Student;
    entity StudentCourse                 as projection on training.StudentCourse;
}

define service CatalogService {
    entity Products          as
        select from logali.materials.Products {
            // ID,
            // Name            as ProductName     @mandatory,
            // Description                        @mandatory,
            // ImageUrl,
            // ReleaseDate,
            // DiscontinuedDate,
            // Price                              @mandatory,
            // Height,
            // Width,
            // Depth,

            *, //Selector inteligente, solo considera todos los datos que estan antes de la columna quantity
            Quaintity,
            UnitOfMeasure   as ToUnitOfMeasure @mandatory,
            Currency        as ToCurrency      @mandatory,
            Category        as ToCategory      @mandatory,
            Category.Name   as Category        @readonly,
            DimensionsUnits as ToDimensionUnit,
            ToSalesData,
            Supplier,
            Reviews,
        };

    @readonly //Esto hace que la llamada al HTTP solo sea READONLY(GET)
    entity Supplier          as
        select from logali.sales.Suppliers {
            ID,
            Name,
            Email,
            Phone,
            Fax,
            Product as ToProduct
        };

    entity Reviews           as
        select from logali.materials.ProductReview {
            ID,
            Name,
            Rating,
            Coment,
            createdAt,
            Product as ToProduct
        };

    @readonly
    entity SalesData         as
        select from logali.sales.SalesData {
            ID,
            DeliveryDate,
            revenue,
            Currency.ID               as CurrencyKey,
            DeliveryMonth.ID          as DeliveryMonthId,
            DeliveryMonth.Description as DeliveryMonth,
            Product                   as ToProduct
        };

    @readonly
    entity StockAvailability as
        select from logali.materials.StockAvailability {
            ID,
            Description,
            Product as ToProduct,
        };

    @readonly
    //VH_ quiere decir Value Help es nomenclatura para ayuda de busqueda, esto normalmente se expone read_only
    entity VH_Categories     as
        select from logali.materials.Categories {
            ID   as Code,
            Name as Text
        };

    @readonly
    entity VH_Currencies     as
        select from logali.materials.Currencies {
            ID          as Code,
            Description as Text
        };

    @readonly
    entity VH_UnityOfMeasure as
        select from logali.materials.UnitOfMeasures {
            ID          as Code,
            Description as Text
        };

    @readonly
    //Proyeccion con Postfix que basicamente es que los campos a seleccionar van antes del from
    entity VH_DimensionUnits as
        select
            ID          as Code,
            Description as Text
        from logali.materials.DimensionsUnits;

}


define service MyService {
    // Expresiones de Ruta
    entity SupplierProduct as
        select from logali.materials.Products[Name = 'Producto1']{
            *,
            Name,
            Description,
            Supplier.Address
        }
        where
            Supplier.Address.PostalCode = 1;

    // Expresiones de Ruta
    entity SupplierToSales as
        select
            Supplier.Email,
            Category.Name,
            ToSalesData.Currency.ID,
            ToSalesData.Currency.Description
        from logali.materials.Products;

    //Infix Filtro a nivel a asosiacion
    entity EntityInfix     as
        select Supplier[Name = 'Matias'].Phone from logali.materials.Products
        where
            Products.Name = 'Producto2';

    //Sin Infix: Misma respuesta
    entity EntityJoin      as
        select Phone from logali.materials.Products
        left join logali.sales.Suppliers as supp
            on(
                supp.ID = Products.Supplier.ID
            )
            and supp.Name = 'Matias'
        where
            Products.Name = 'Producto2';
}

//Agrupaciones
define service Reports {
    entity AvarageRating as projection on logali.reports.AvarageRating;


    entity Products      as
        select from logali.reports.Products {
            ID,
            Name            as ProductName     @mandatory,
            Description                        @mandatory,
            ImageUrl,
            ReleaseDate,
            DiscontinuedDate,
            Price                              @mandatory,
            Height,
            Width,
            Depth,
            Quaintity                          @(
                mandatory,
                assert.range: [
                    0.00,
                    20
                ]
            ),
            UnitOfMeasure   as ToUnitOfMeasure @mandatory,
            Currency        as ToCurrency      @mandatory,
            Category        as ToCategory      @mandatory,
            Category.Name   as Category        @readonly,
            DimensionsUnits as ToDimensionUnit,
            ToSalesData,
            Supplier,
            //Reviews,
            Rating,
            StockAvailability,
            ToStockAvailability
        };

    entity EntityCasting as
        select
            cast(
                Price as      Integer
            )     as Price,
            Price as Price2 : Integer
        from logali.materials.Products;
    // Exists - Trae los nombres de los productos cuando el nombe del supplier sea Matias
    entity EntityExists as
        select from logali.materials.Products {
            Name
        } where exists Supplier[Name = 'Matias'];
}
