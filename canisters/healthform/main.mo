import HashMap "mo:base/HashMap";
import Nat "mo:base/Nat";
import Iter "mo:base/Iter";
import Nat32 "mo:base/Nat32";
import Text "mo:base/Text";
import Principal "mo:base/Principal";
import Debug "mo:base/Debug";

actor PatientCrud {

	type PatientId = Nat32;
	type Patient = {
		creator: Text;
		name: Text;
		age: Text;
		pressure: Text;
		temperature: Text;
	};

	
	stable var patientId: PatientId = 0;
	let patientList = HashMap.HashMap<Text, Patient>(0, Text.equal, Text.hash);

	private func generateTaskId() : Nat32 {
		patientId += 1;
		return patientId;
	};

	public shared (msg) func registerPatient(name: Text, age: Text, pressure:Text, temperature:Text) : async () {
		let user: Text = Principal.toText(msg.caller);
		let patient = {creator=user; name=name; age=age; pressure=pressure; temperature=temperature};

		patientList.put(Nat32.toText(generateTaskId()), patient);
		Debug.print("New patient registered ID: " # Nat32.toText(patientId));
		return ();
	};

	public query func getPatients () : async [(Text, Patient)] {
		let patientIter : Iter.Iter<(Text, Patient)> = patientList.entries();
		let patientArray : [(Text, Patient)] = Iter.toArray(patientIter);

		return patientArray;
	};

	public query func getPatient (id: Text) : async ?Patient {
		let patient: ?Patient = patientList.get(id);
		return patient;
	};

	
	public shared (msg) func updatePatient (id: Text, name: Text, age: Text, pressure: Text, temperature: Text,) : async Bool {
		let user: Text= Principal.toText(msg.caller);
		let patient: ?Patient = patientList.get(id);

		switch (patient) {
			case (null) {
				return false;
			};
			case (?currentPatient) {
				let newPatient: Patient = {creator=user; name=name; age=age; pressure=pressure; temperature=temperature; };
				patientList.put(id, newPatient);
				Debug.print("Updated patient with ID: " # id);
				return true;
			};
		};

	};

	public func deletePatient (id: Text) : async Bool {
		let patient : ?Patient = patientList.get(id);
		switch (patient) {
			case (null) {
				return false;
			};
			case (_) {
				ignore patientList.remove(id);
				Debug.print("Delete patient with ID: " # id);
				return true;
			};
		};
	};
	
}
