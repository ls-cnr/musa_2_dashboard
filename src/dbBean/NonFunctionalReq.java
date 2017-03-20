package dbBean;

// Generated 1-mar-2017 16.50.58 by Hibernate Tools 3.4.0.CR1

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import static javax.persistence.GenerationType.IDENTITY;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

/**
 * NonFunctionalReq generated by hbm2java
 */
@Entity
@Table(name = "non_functional_req", catalog = "musa_db")
public class NonFunctionalReq implements java.io.Serializable {

	private Integer idNonFunctionalReq;
	private Specification specification;
	private String name;
	private String value;
	private String description;
	private String currentState;

	public NonFunctionalReq() {
	}

	public NonFunctionalReq(Specification specification, String name,
			String value, String description, String currentState) {
		this.specification = specification;
		this.name = name;
		this.value = value;
		this.description = description;
		this.currentState = currentState;
	}

	@Id
	@GeneratedValue(strategy = IDENTITY)
	@Column(name = "idNonFunctional_Req", unique = true, nullable = false)
	public Integer getIdNonFunctionalReq() {
		return this.idNonFunctionalReq;
	}

	public void setIdNonFunctionalReq(Integer idNonFunctionalReq) {
		this.idNonFunctionalReq = idNonFunctionalReq;
	}

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "idSpecification")
	public Specification getSpecification() {
		return this.specification;
	}

	public void setSpecification(Specification specification) {
		this.specification = specification;
	}

	@Column(name = "name")
	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Column(name = "value")
	public String getValue() {
		return this.value;
	}

	public void setValue(String value) {
		this.value = value;
	}

	@Column(name = "description", length = 45)
	public String getDescription() {
		return this.description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	@Column(name = "current_state", length = 25)
	public String getCurrentState() {
		return this.currentState;
	}

	public void setCurrentState(String currentState) {
		this.currentState = currentState;
	}

}
