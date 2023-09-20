import type { Principal } from '@dfinity/principal';
import type { ActorMethod } from '@dfinity/agent';

export interface Patient { 'creator' : string, 'nombre' : string, 'age' : string, 'pressure' : string, 'temperature' : string,  }
export interface _SERVICE {
  'registerPatient' : ActorMethod<[string, string, string, string], undefined>,
  'deletePatient' : ActorMethod<[string], boolean>,
  'getPatient' : ActorMethod<[string], [] | [Patient]>,
  'getPatients' : ActorMethod<[], Array<[string, Patient]>>,
  'updatePatient' : ActorMethod<[string, string, string, string, string], boolean>,
  'getNumberofPatients' : ActorMethod<[], Int>,
}


