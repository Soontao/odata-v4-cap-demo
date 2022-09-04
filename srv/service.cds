using {
  People,
  Order
} from '../db/schema';

service ODataService {

  entity Peoples as projection on People actions {
    function getName() returns String;
    action   updateName(UserName : String);
  }

  entity Orders  as projection on Order;
  function getPeopleName(ID : UUID) returns String;
  action   updatePeopleName(ID : UUID, UserName : String);

}
