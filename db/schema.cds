using {
  cuid,
  managed
} from '@sap/cds/common';


type PeopleName : {
  FirstName  : String(255);
  MiddleName : String(255);
  LastName   : String(255);
  NickName   : String(255);
}


entity People : cuid, managed {

  @assert.unique
  UserName : String(128);
  Name     : PeopleName;
  details  : Association to many Detail
               on details.people = $self;

}


entity Detail : cuid {
  people : Association to one People;
}
