export const idlFactory = ({ IDL }) => {
  const Patient = IDL.Record({ 'creator' : IDL.Text, 'nombre' : IDL.Text, 'age' : IDL.Text, 'pressure' : IDL.Text, 'temperature' : IDL.Text });
  return IDL.Service({
    'registerPatient' : IDL.Func([IDL.Text, IDL.Text, IDL.Text, IDL.Text], [], []),
    'deletePatient' : IDL.Func([IDL.Text], [IDL.Bool], []),
    'getPatient' : IDL.Func([IDL.Text], [IDL.Opt(Patient)], ['query']),
    'getPatients' : IDL.Func([], [IDL.Vec(IDL.Tuple(IDL.Text, Patient))], ['query']),
    'updatePatient' : IDL.Func([IDL.Text, IDL.Text, IDL.Text, IDL.Text, IDL.Text], [IDL.Bool], []),
    'getNumberofPatients' : IDL.Func([], [IDL.Int], []),
  });
};
export const init = ({ IDL }) => { return []; };
