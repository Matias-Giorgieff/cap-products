namespace com.logali;

using {
    cuid,
    managed
} from '@sap/cds/common';


define type Name : String(50);

type Address     : {
    Street     : String;
    City       : String;
    State      : String(2);
    PostalCode : String(5);
    Country    : String(3);
};


context materials {
    entity Products : cuid, managed {
        //key ID               : UUID;
        Name             : localized String not null; //default 'NoName';
        Description      : localized String;
        ImageUrl         : String;
        ReleaseDate      : DateTime default $now; //Insert el datetime que tiene en tiempo de ejecucion
        DiscontinuedDate : DateTime; // Date default CURRENT_DATE; //Fecha de sistema
        Price            : Decimal(16, 2);
        Height           : type of Price; //Decimal(16, 2);
        Width            : Decimal(16, 2);
        Depth            : Decimal(16, 2);
        Quaintity        : Decimal(16, 2);
        //Asociaciones no administradas - Se asocia manualmente//
        // Supplier_Id      : UUID;
        // toSupplier       : Association to one Suppliers
        //                        on toSupplier.ID = Supplier_Id; // Asociamos el ID de suppliers a Products
        // UnitOfMeasure_Id : String(2);
        // ToUnitOfMeasure  : Association to UnitOfMeasures
        //                        on ToUnitOfMeasure.ID = UnitOfMeasure_ID;
        //Asociaciones administradas - Se asocia automaticamente//
        Supplier         : Association to one sales.Suppliers;
        UnitOfMeasure    : Association to UnitOfMeasures;
        Currency         : Association to Currencies;
        DimensionsUnits  : Association to DimensionsUnits;
        Category         : Association to Categories;
        ToSalesData      : Association to many sales.SalesData
                               on ToSalesData.Product = $self;
        Reviews          : Association to many ProductReview
                               on Reviews.Product = $self;
        Rating : Decimal(16, 2);

    }


    entity Categories {
        key ID   : String(1);
            Name : localized String;
    }

    entity StockAvailability {
        key ID          : Integer;
            Description : localized String;
            Product     : Association to Products;
    }

    entity Currencies {
        key ID          : String(3);
            Description : localized String;
    }

    entity UnitOfMeasures {
        key ID          : String(2);
            Description : localized String;
    }

    entity DimensionsUnits {
        key ID          : String(2);
            Description : localized String;
    }

    entity ProductReview : cuid, managed {
        Name    : localized String;
        Rating  : Integer;
        Coment  : localized String;
        Product : Association to Products;
    }

    //Entidad Projection
    // en SQL serian Vista de tipo Projection
    // Estas no soportan los Join ni las Union
    entity ProjProducts  as projection on Products;

    entity ProjProducts2 as
        projection on Products {
            ReleaseDate,
            Name
        };


    // Ampliamos una entidad
    extend Products with {
        PriceCondition     : String(2);
        PriceDetermination : String(3);
        StockAvailability  : Association to StockAvailability;
    }

}

context sales {

    // La composicion no existe sin el padre
    entity Orders : cuid {
        //key ID       : UUID;
        Date     : Date;
        Customer : String;
        Item     : Composition of many OrderItems
                       on Item.Order = $self;
    // Item     : Composition of many {
    //                key Position  : Integer;
    //                    Order     : Association to Orders;
    //                    Product   : Association to Products;
    //                    Quaintity : Integer;
    //            }
    }

    entity OrderItems : cuid {
        //key ID        : UUID;
        Order     : Association to Orders;
        Product   : Association to materials.Products;
        Quaintity : Integer;
    }


    entity Suppliers : cuid, managed {
        //key ID      : UUID;
        Name    : type of materials.Products : Name; //String; // Referencia de la entidad Products campo Name
        Address : Address;
        Email   : String;
        Phone   : String;
        Fax     : String;
        Product : Association to many materials.Products
                      on Product.Supplier = $self;
    }


    entity Months {
        key ID               : String(2);
            Description      : localized String;
            ShortDescription : localized String(3);
    }

    entity SalesData : cuid, managed {
        //key ID            : UUID;
        DeliveryDate  : DateTime;
        revenue       : Decimal(16, 2);
        Product       : Association to materials.Products;
        Currency      : Association to materials.Currencies;
        DeliveryMonth : Association to Months;
    }

    //Entidades de proyeccion o con select
    //A nivel de SQL es una vista
    // Estas entidades se pueden usar para exponerlas como servicios OData
    entity SelProducts  as select from materials.Products;

    entity SelProducts1 as
        select from materials.Products {
            *
        };

    entity SelProducts2 as
        select from materials.Products {
            Name,
            Price,
            Quaintity
        };

// entity SelProducts3 as
//     select from materials.Products
//     left join materials.ProductReview
//         on Products.Name = ProductReview.Name
//     {
//         Rating,
//         Products.Name,
//         sum(Price) as TotalPrice,
//     }
//     group by
//         Rating,
//         Products.Name
//     order by
//         Rating;

}

context reports {
    entity AvarageRating as
        select from logali.materials.ProductReview {
            Product.ID  as ProductId,
            avg(Rating) as AvarageRating : Decimal(16, 2)
        }
        group by
            Product.ID;


    //Mixin - asociaciones no administradas
    entity Products      as
        select from logali.materials.Products
        mixin {
            ToStockAvailability : Association to logali.materials.StockAvailability
                                      on ToStockAvailability.ID = $projection.StockAvailability;

            ToAvarageRating     : Association to AvarageRating
                                      on ToAvarageRating.ProductId = ID;
        }
        into {
            *,
            ToAvarageRating as Rating,
            case
                when
                    Quaintity >= 8
                then
                    3
                when
                    Quaintity > 0
                then
                    2
                else
                    1
            end             as StockAvailability : Integer,
            ToStockAvailability
        }
}
