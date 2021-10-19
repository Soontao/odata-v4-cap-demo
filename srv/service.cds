using {
  People,
  Detail
} from '../db/schema';

service ODataService {

  entity Peoples as projection on People;
  entity Details as projection on Detail;

}
