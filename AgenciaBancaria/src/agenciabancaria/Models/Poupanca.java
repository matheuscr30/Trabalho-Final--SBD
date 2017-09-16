/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package agenciabancaria.Models;

/**
 *
 * @author matheus
 */
public class Poupanca {
    private String agencia_nome;
    private int id_conta;
    private float taxa_juros;

    public String getAgencia_nome() {
        return agencia_nome;
    }

    public void setAgencia_nome(String agencia_nome) {
        this.agencia_nome = agencia_nome;
    }

    public int getId_conta() {
        return id_conta;
    }

    public void setId_conta(int id_conta) {
        this.id_conta = id_conta;
    }

    public float getTaxa_juros() {
        return taxa_juros;
    }

    public void setTaxa_juros(float taxa_juros) {
        this.taxa_juros = taxa_juros;
    }
    
    
}
