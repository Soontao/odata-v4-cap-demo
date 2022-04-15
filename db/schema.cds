using {
  cuid,
  managed
} from '@sap/cds/common';

using {incrementID} from 'cds-mysql';

type PeopleName : {
  FirstName  : String(255);
  MiddleName : String(255);
  LastName   : String(255);
  NickName   : String(255);
}


entity People : incrementID, managed {

  @assert.unique
  UserName : String(128);
  Name     : PeopleName;
  details  : Association to many Detail
               on details.people = $self;

}


entity Detail : incrementID {
  people : Association to one People;
}
