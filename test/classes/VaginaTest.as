package classes{
    import org.flexunit.asserts.*;
	import org.hamcrest.assertThat;
	import org.hamcrest.core.*;
	import org.hamcrest.number.*;
	import org.hamcrest.object.*;
	import org.hamcrest.text.*;
	
	
	import classes.Vagina;
	import classes.internals.SerializationUtils;
	
    public class VaginaTest {
		private static const LABIA_PIERCED:int = 1;
		private static const CLIT_LENGTH:Number = 2.5;
		private static const RECOVERY_PROGRESS:int = 42;
		
        private var cut:Vagina;
		private var serializedClass:*;
		
        [Before]
        public function runBeforeEveryTest():void {
			cut = new Vagina();
			serializedClass = [];
        }  
     
        [Test(description="Default clit length const is not used so that changes to the default value will cause this test to fail")] 
        public function testVaginaDefaultValueForClitLength():void {
			assertThat(cut.clitLength, equalTo(0.5));
        }
		
		[Test] 
        public function testValidateClitLengthNegative():void {
			cut = new Vagina(1, 0, true, -1);
			
			assertThat(cut.validate(), containsString("clitLength"));
        }
		
		[Test] 
        public function testValidateClitLengthPositive():void {
			cut = new Vagina(1, 0, true, 2);
			
			assertThat(cut.validate(), not(containsString("clitLength")));
        }
		
		[Test] 
        public function testValidateRecoveryProgressNegative():void {
			cut.recoveryProgress = -1;
			
			assertThat(cut.validate(), containsString("recoveryProgress"));
        }
		
		[Test] 
        public function testValidateRecoveryProgressNotNegative():void {
			cut = new Vagina();
			
			assertThat(cut.validate(), not(containsString("recoveryProgress")));
        }
		
		[Test] 
        public function testWetnessFactorZero():void {
			cut.vaginalWetness = 0;
			
			assertThat(cut.wetnessFactor(), equalTo(1));
        }
		
		[Test] 
        public function testWetnessFactorFive():void {
			cut.vaginalWetness = 5;
			
			assertThat(cut.wetnessFactor(), equalTo(1.5));
        }
		
		[Test] 
        public function testResetRecoveryProgress():void {
			cut.recoveryProgress = 1;
			
			cut.resetRecoveryProgress();
			
			assertThat(cut.recoveryProgress, equalTo(0));
        }
		
		[Test]
		public function serializedClassHasRecoveryProgressProperties():void {
			cut.serialize(serializedClass);
			
			assertThat(serializedClass, hasProperty("recoveryProgress"));
		}
		
		[Test]
		public function serializedClassHasClitLengthProperties():void {
			cut.serialize(serializedClass);
			
			assertThat(serializedClass, hasProperty("clitLength"));
		}
		
		[Test]
		public function deserializeWithoutLabiaPierced():void {
			SerializationUtils.deserialize(serializedClass, cut);
			
			assertThat(cut.labiaPierced, equalTo(0));
		}
		
		private function setLabiaPierced():void {
			serializedClass.labiaPierced = LABIA_PIERCED;
		}
		
		private function setClitLength():void {
			serializedClass.clitLength = CLIT_LENGTH;
		}
		
		[Test]
		public function deserializeWithLabiaPierced():void {
			setLabiaPierced();
			
			cut.deserialize(serializedClass);
			
			assertThat(cut.labiaPierced, equalTo(LABIA_PIERCED));
		}
		
		private function setRecoveryProgress():void {
			serializedClass.recoveryProgress = RECOVERY_PROGRESS;
		}
		
		[Test]
		public function deserializeNoVaginaType():void {
			SerializationUtils.deserialize(serializedClass, cut);
			
			assertThat(cut.type, equalTo(0));
		}
		
		[Test]
		public function deserializeHumanVaginaType():void {
			serializedClass.type = 0;
			
			SerializationUtils.deserialize(serializedClass, cut);
			
			assertThat(cut.type, equalTo(0));
		}
		
		[Test]
		public function deserializeEquineVaginaType():void {
			serializedClass.type = 5;
			
			SerializationUtils.deserialize(serializedClass, cut);
			
			assertThat(cut.type, equalTo(5));
		}
		
		[Test]
		public function deserializeLabiaPiercedUndefined():void {
			SerializationUtils.deserialize(serializedClass, cut);
			
			assertThat(cut.labiaPierced, equalTo(0));
		}
		
		[Test]
		public function deserializeLabiaPierced():void {
			setLabiaPierced();
			
			SerializationUtils.deserialize(serializedClass, cut);
			
			assertThat(cut.labiaPierced, equalTo(LABIA_PIERCED));
		}

		[Test]
		public function deserializeClitLengthUndefined():void {
			SerializationUtils.deserialize(serializedClass, cut);
			
			assertThat(cut.clitLength, equalTo(Vagina.DEFAULT_CLIT_LENGTH));
		}

		[Test]
		public function deserializeClitLength():void {
			setClitLength();
			
			SerializationUtils.deserialize(serializedClass, cut);
			
			assertThat(cut.clitLength, equalTo(CLIT_LENGTH));
		}
		
		[Test]
		public function deserializeRecoveryProgressUndefined():void {
			SerializationUtils.deserialize(serializedClass, cut);
			
			assertThat(cut.recoveryProgress, equalTo(0));
		}
		
		[Test]
		public function deserializeRecoveryProgress():void {
			setRecoveryProgress();
			
			SerializationUtils.deserialize(serializedClass, cut);
			
			assertThat(cut.recoveryProgress, equalTo(RECOVERY_PROGRESS));
		}
	}
}
