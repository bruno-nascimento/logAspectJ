package aspectLog;


public class Teste {
	
	public static void main(String[] args) {
		Teste teste = new Teste();
		teste.teste1("syso teste1 ### lero lero vc não me intercepta");
		teste.teste2();
		Entidade entidade = new Entidade();
		System.out.println("-=-=-=-=-=-=-=-=-=- valor depois: "+entidade.getParametro3());
		teste.alteraEntidade(entidade);
		System.out.println("-=-=-=-=-=-=-=-=-=- valor depois: "+entidade.getParametro3());
	}
	
	public String teste1(String retorno){
		System.out.println(retorno);
		return retorno;
	}
	
	public void teste2(){
		System.out.println("syso teste2");
	}
	
	@Log @AlteraEntidade
	public Entidade alteraEntidade(Entidade entidade){
		entidade.setParametro3(new Integer(20)); 
		System.out.println("ALTEREI O Entidade.parametro3 PARA >> " + entidade.getParametro3() + " no #alteraEntidade(Entidade)");
		return entidade;
	}
	
}
