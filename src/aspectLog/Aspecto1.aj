package aspectLog;

import java.lang.reflect.Field;

public aspect Aspecto1 {
	
	pointcut teste() :
		call(void Teste.teste2());
	
	pointcut teste1(): 
		call(String Teste.teste1(String));
	
	pointcut teste1ComArgs(Teste teste, String retorno):
		call(String Teste.teste1(String))
		&& target(teste)
		&& args(retorno);
	
	pointcut log():
		execution(@aspectLog.Log * *.*(..));
	
	pointcut alteraEntidade():
		execution(@aspectLog.AlteraEntidade * *.*(..));
	
	before() : teste() {
		System.out.println("############# BEFORE! teste2");
	}
	
	after() : teste(){
		System.out.println("############### AFTER! teste2");
	}

	after() : teste1(){
		System.out.println("############# AFTER! teste1");
	}
	
	before(Teste teste, String retorno): teste1ComArgs(teste,retorno){
		System.out.println("interceptei o parametro:::>>>"+retorno);
	}
	
	before() : teste1(){
		System.out.println("$$$$$$$$$$$$$$ teste111111");
	}
	
	before() : log(){
		try {
			System.out.println("##### INTERCEPTOU METODO ANOTADO COM @LOG");
			Object[] argumentos = thisJoinPoint.getArgs();
			System.out.println("@# FIELDS DOS PARAMETROS#@");
			for(Object object : argumentos){
				System.out.println("-- TIPO PARAM: "+object.getClass());
				for(Field field : object.getClass().getDeclaredFields()){
					field.setAccessible(true);
					System.out.println(field.getName() + " :: " +field.get(object).toString());
				}
			}
		} catch (IllegalArgumentException e) {
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		}
	}
	
	after(): alteraEntidade(){
		try {
			System.out.println("#### AFTER ALTERA ENTIDADE");
			Object[] argumentos = thisJoinPoint.getArgs();
			for(Object object : argumentos){
				System.out.println(object.getClass());
				Field field = object.getClass().getDeclaredField("parametro3");
				field.setAccessible(true);
				field.set(object, new Integer(99));
			}
		} catch (SecurityException e) {
			e.printStackTrace();
		} catch (NoSuchFieldException e) {
			e.printStackTrace();
		} catch (IllegalArgumentException e) {
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		}
	}
	
}
