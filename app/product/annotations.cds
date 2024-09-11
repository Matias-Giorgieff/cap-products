using CatalogService as service from '../../srv/catalog-service';







annotate service.Products with @odata.draft.enabled;
annotate service.Products with @odata.draft.bypass;

annotate service.Products with @(
    Capabilities                 : {
        InsertRestrictions: {
            $Type     : 'Capabilities.InsertRestrictionsType',
            Insertable: true
        },
        DeleteRestrictions: {
            $Type    : 'Capabilities.DeleteRestrictionsType',
            Deletable: true
        },
        
        UpdateRestrictions: {
            $Type    : 'Capabilities.UpdateRestrictionsType',
            Updatable: true
        }

    },

    UI.HeaderInfo                : {
        TypeName      : '{i18n>Product}',
        TypeNamePlural: '{i18n>Products}',
        ImageUrl      : ImageUrl,
        Title         : {Value: Name},
        Description   : {Value: Description}
    },

    // Estos los cambiamos por campo.id ya que no se les puede cambiar el texto
    // UI.SelectionFields           : [
    //     ToCategory_ID,
    //     ToCurrency_ID,
    //     StockAvailability_ID,
    //     ToUnitOfMeasure_ID,
    //     ToDimensionUnit_ID

    // ],
    UI.SelectionFields           : [
        CategoryId,
        CurrencyId,
        StockAvailabilityId,
        UnitOfMeasureId,
        DimensionsUnitsId

    ],
    UI.FieldGroup #GeneratedGroup: {
        $Type: 'UI.FieldGroupType',
        Data : [

            {
                $Type: 'UI.DataField',
                Label: '{i18n>ReleaseDate}',
                Value: ReleaseDate,
            },
            {
                $Type: 'UI.DataField',
                Label: 'DiscontinuedDate',
                Value: DiscontinuedDate,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Price',
                Value: Price,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Height',
                Value: Height,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Width',
                Value: Width,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Depth',
                Value: Depth,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Quaintity',
                Value: Quaintity,
            },
            // {
            //     $Type: 'UI.DataField',
            //     Label: 'UnitOfMeasure_ID',
            //     Value: UnitOfMeasure_ID,
            // },
            {
                $Type: 'UI.DataField',
                Label: '{i18n>Currency}',
                Value: Currency_ID,
            },
            {
                $Type: 'UI.DataField',
                Label: 'DimensionsUnits_ID',
                Value: DimensionsUnits_ID,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Category',
                Value: Category,
            },
            {
                $Type: 'UI.DataField',
                Label: 'PriceCondition',
                Value: PriceCondition,
            },
            {
                $Type: 'UI.DataField',
                Label: 'PriceDetermination',
                Value: PriceDetermination,
            },
            {
                $Type: 'UI.DataField',
                Label: 'ToUnitOfMeasure_ID',
                Value: ToUnitOfMeasure_ID,
            },
            {
                $Type: 'UI.DataField',
                Label: 'ToCurrency_ID',
                Value: ToCurrency_ID,
            },
            {
                $Type: 'UI.DataField',
                Label: 'ToCategory_ID',
                Value: ToCategory_ID,
            },
            {
                $Type: 'UI.DataField',
                Label: 'ToDimensionUnit_ID',
                Value: ToDimensionUnit_ID,
            },

        // {
        //     $Type : 'UI.DataFieldForAnnotation',
        //     Label : 'Rating',
        //     Target: '@UI.DataPoint#AvarageRating'
        // },
        ],
    },
    UI.Facets                    : [
        {
            $Type : 'UI.ReferenceFacet',
            ID    : 'GeneratedFacet1',
            Label : 'General Information',
            Target: '@UI.FieldGroup#GeneratedGroup',
        },
        {
            $Type : 'UI.ReferenceFacet',
            ID    : 'GeneratedFacet2',
            Label : 'General Information Copia',
            Target: '@UI.FieldGroup#GeneratedGroup',
        },
    ],
    UI.HeaderFacets              : [{
        $Type : 'UI.ReferenceFacet',
        Target: '@UI.DataPoint#AvarageRating'
    }],
    UI.LineItem                  : [
        {
            $Type: 'UI.DataField',
            Label: 'ImageUrl',
            Value: ImageUrl,
        },
        {
            $Type: 'UI.DataField',
            Label: 'Name',
            Value: Name,
        },
        {
            $Type: 'UI.DataField',
            Label: 'Description',
            Value: Description,
        },
        {
            $Type : 'UI.DataFieldForAnnotation',
            Label : 'Supplier',
            Target: 'Supplier/@Communication.Contact',
        },

        {
            $Type: 'UI.DataField',
            Label: 'ReleaseDate',
            Value: ReleaseDate,
        },
        {
            $Type: 'UI.DataField',
            Label: 'DiscontinuedDate',
            Value: DiscontinuedDate,
        },
        {
            Label      : 'Stock Availability',
            Value      : StockAvailability_ID,
            Criticality: StockAvailability_ID,
        },
        {
            $Type: 'UI.DataField',
            Label: 'Price',
            Value: Price,
        },
        {
            $Type : 'UI.DataFieldForAnnotation',
            Label : 'Rating',
            Target: '@UI.DataPoint#AvarageRating'
        },

    ],
);

