namespace com.training;

using {cuid,
       Country
             //managed
       } from '@sap/cds/common';


////////////ARRAY////////////
// type EmailsAddresses_01 : array of {
//     kind  : String;
//     email : String;
// };

// type EmailsAddresses_02 {
//     kind  : String;
//     email : String;
// };

// entity Emails {
//     email_01 :      EmailsAddresses_01;
//     email_02 : many EmailsAddresses_02;
//     email_03 : many {
//         kind  : String;
//         email : String;
//     }
// }


////////////ENUM////////////
// type Gender      : String enum {
//     male;
//     female;
// };

// entity Order {
//     clientGender : Gender;
//     status       : Integer enum {
//         submit    = 1;
//         fulfiller = 2;
//         shipped   = 3;
//         cancel    = -1;
//     };
//     priority     : String @assert.range enum {
//         high;
//         medium;
//         low;
//     }
// }

////////////ELEMENTOS VIRTUALES////////////
// entity Car {
//     key ID                 : UUID;
//         name               : String;
//         virtual discount_1 : Decimal; //Elemento Virtual, no se genera en bdd Estan pensados para desde la app devolver datos a la capa de bdd no para recibir datos
//         @Core.Computed: false // Con esto permitimos que discont_2 pueda llegar de bdd como un dato normal
//         virtual discount_2 : Decimal;

// }


/////////////////////////////Entidades con parametros estas entidades son solamente soportadas con base de datos HANA (En este momento tenemos SQLite y no es compatible)
// entity ParamProducts(pName : String) as
//     select from Products {
//         Name,
//         Price,
//         Quaintity
//     }
//     where
//         Name = :pName;

// entity ProjParamProducts(pName : String) as projection on Products where Name = :pName;


// Ejemplo relacion many to many
entity Course : cuid {
    //key ID      : UUID;
    Student : Association to many StudentCourse
                  on Student.Course = $self;
}


entity Student : cuid {
    //key ID     : UUID;
    Course : Association to many StudentCourse
                 on Course.Student = $self;
}


entity StudentCourse : cuid {
    //key ID      : UUID;
    Student : Association to Student;
    Course  : Association to Course;
}

entity Orders {
    key ClientEmail : String(65);
        FirstName   : String(30);
        LastName    : String(30);
        CreatedOn   : Date;
        Reviewed    : Boolean;
        Aprroved    : Boolean;
        Country     : Country;

}
